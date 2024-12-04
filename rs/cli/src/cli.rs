use clap::{Parser, Subcommand};

#[derive(Parser, Debug)]
#[command(version)]
pub struct Cli {
    #[command(subcommand)]
    pub command: Commands,
}

#[derive(Subcommand, Debug)]
pub enum Commands {
    Diff {
        #[arg(long)]
        old_text: String,
        #[arg(long)]
        new_text: String,
    },
}
