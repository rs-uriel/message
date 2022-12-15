package cmd

import (
	"context"
	"fmt"

	"github.com/spf13/cobra"
)

var (
	startCmd = &cobra.Command{
		Use:   "start",
		Short: "Start server",
		Long:  "Start message server",
		Run: func(cmd *cobra.Command, args []string) {
			ctx := context.Background()

			fmt.Printf("%s", ctx)
		},
	}
)
