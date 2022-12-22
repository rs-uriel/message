package cmd

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/olahol/melody"
	"github.com/spf13/cobra"
)

var (
	cfgFilePath string
	cfgKey      string

	rootCmd = &cobra.Command{
		Use:   "client",
		Short: "Simple Temporal Client",
		Long:  "Change Simple Temporal Client that runs a workflow",
		Run: func(cmd *cobra.Command, args []string) {
			r := gin.Default()
			m := melody.New()

			r.LoadHTMLGlob("pkg/server/cmd/*.tmpl")

			r.GET("/ws", func(c *gin.Context) {
				m.HandleRequest(c.Writer, c.Request)
			})

			r.GET("/", func(c *gin.Context) {
				c.HTML(http.StatusOK, "index.tmpl", gin.H{
					"title": "Uriel's chat",
				})
			})

			m.HandleMessage(func(s *melody.Session, msg []byte) {
				m.Broadcast(msg)
			})
			r.Run(":5005")
		},
	}
)

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
