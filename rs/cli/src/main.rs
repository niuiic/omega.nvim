use clap::Parser;

mod cli;

fn main() {
    let command = cli::Cli::parse().command;

    match command {
        cli::Commands::Diff { old_text, new_text } => {
            match text_edit::get_line_level_text_edits(
                old_text[1..old_text.len() - 1].to_string(),
                new_text[1..new_text.len() - 1].to_string(),
            ) {
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
