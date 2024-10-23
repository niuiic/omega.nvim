use lsp_types::{Position, Range, TextEdit};
use mlua::{prelude::*, RegistryKey};
use similar::{ChangeTag, TextDiff};

// % diff_text %
pub async fn lua_diff_text<'a>(
    lua: &'a Lua,
    (old_text, new_text, callback): (String, String, LuaFunction<'a>),
) -> LuaResult<()> {
    let callback_key: RegistryKey = lua.create_registry_value(callback.clone()).unwrap();
    callback.call::<String, ()>("hello".to_string()).unwrap();
    lua.remove_registry_value(callback_key).unwrap();
    Ok(())
}

// % calc_text_edits %
fn calc_text_edits(old_text: String, new_text: String) -> Result<Vec<TextEdit>, String> {
    let mut edits = Vec::<TextEdit>::new();

    let diff = TextDiff::from_lines(&old_text, &new_text);

    let mut start_lnum = 0;
    let mut start_col = 0;

    for change in diff.iter_all_changes() {
        println!(
            "[1] QUICK_PRINT(omega-rs/src/diff.rs:20) change = {:?}",
            change
        );
        match change.tag() {
            ChangeTag::Delete => {
                let range = Range {
                    start: Position::new(start_lnum, start_col),
                    end: Position::new(start_lnum, start_col + change.value().len() as u32),
                };
                edits.push(TextEdit {
                    range,
                    new_text: "".to_string(),
                });
            }
            ChangeTag::Insert => {
                let range = Range {
                    start: Position::new(start_lnum, start_col),
                    end: Position::new(start_lnum, start_col),
                };
                edits.push(TextEdit {
                    range,
                    new_text: change.value().to_string(),
                });
            }
            ChangeTag::Equal => {
                let lines = change.value().lines().count() as u32;
                start_lnum += lines;
                start_col = 0;
            }
        }
    }

    Ok(edits)
}

// % test %
#[cfg(test)]
mod tests {
    use std::{env, fs};

    use super::*;

    #[test]
    fn test_calc_text_edits() {
        let current_dir = env::current_dir().unwrap();

        let old_text = fs::read_to_string(current_dir.join("tests/diff/old.md").as_path()).unwrap();
        let new_text = fs::read_to_string(current_dir.join("tests/diff/new.md").as_path()).unwrap();

        let result = calc_text_edits(old_text, new_text);
    }
}
