use std::{env, io, io::Read};

use anyhow::Result;
use serde::Deserialize;
use serde_json;
use text_edit;

fn main() {
    let args = &env::args().collect::<Vec<String>>();
    if args.len() < 2 {
        eprintln!("missing command");
        return;
    }
    let command = &args[1];

    match command.as_str() {
        "diff" => {
            let stdin = read_stdin().unwrap();
            let args = serde_json::from_str::<DiffArgs>(&stdin).unwrap();

            match text_edit::get_line_level_text_edits(args.old_text, args.new_text) {
                Err(e) => {
                    eprintln!("{}", e)
                }
                Ok(text_edits) => {
                    println!("{}", serde_json::to_string(&text_edits).unwrap());
                }
            }
        }
        _ => {}
    }
}

fn read_stdin() -> Result<String> {
    let mut buffer = Vec::new();
    io::stdin().read_to_end(&mut buffer)?;
    let input = String::from_utf8(buffer)?;
    Ok(input)
}

#[derive(Debug, Deserialize)]
struct DiffArgs {
    new_text: String,
    old_text: String,
}
