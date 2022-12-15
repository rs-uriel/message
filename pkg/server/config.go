package client

type Config struct {
	Env         string `mapstructure:"env"`
	Environment string `mapstructure:"environment"`
}
