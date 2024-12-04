use clap::Parser;

mod cli;

fn main() {
    let command = cli::Cli::parse().command;

    match command {
        cli::Commands::Diff { old_text, new_text } => {
            match text_edit::get_line_level_text_edits(old_text, new_text) {
                Err(e) => {
                    eprintln!("{}", e)
                }
                Ok(text_edits) => {
                    println!("{}", serde_json::to_string(&text_edits).unwrap());
                }
            }
        }
    }
}
