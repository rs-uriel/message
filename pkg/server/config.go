package client

import (
	"github.com/retentionscience/pdm/internal/temporal"
)

type Config struct {
	Env				string			`mapstructure:"env"`
	Environment		string			`mapstructure:"environment"`
	Temporal		temporal.Config	`envPrefix:"TEMPORAL_"`
}