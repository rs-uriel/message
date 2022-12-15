package cmd

import (
	"fmt"
	"log"
	"os"

	"github.com/spf13/cobra"
)

var (
	cfgFilePath string
	cfgKey      string

	rootCmd = &cobra.Command{
		Use:   "client",
		Short: "Simple Temporal Client",
		Long:  "Simple Temporal Client that runs a workflow",
		PersistentPreRun: func(cmd *cobra.Command, args []string) {
			log.Print("Starting Pre-run")
		},
	}
)

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
