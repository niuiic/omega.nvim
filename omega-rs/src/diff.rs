use lsp_types::{Position, Range, TextEdit};
use mlua::prelude::*;
use similar::{ChangeTag, TextDiff};

pub fn calc_text_edits(lua: &Lua, texts: (String, String)) -> LuaResult<LuaTable> {
    let table = lua.create_table()?;
    let edits = _calc_text_edits(texts.0, texts.1)?;

    for (i, edit) in edits.iter().enumerate() {
        table.set(i + 1, edit_to_table(lua, edit)?)?;
    }

    Ok(table)
}

fn _calc_text_edits(old_text: String, new_text: String) -> LuaResult<Vec<TextEdit>> {
    let mut edits = Vec::<TextEdit>::new();

    let diff = TextDiff::from_lines(&old_text, &new_text);

    let mut start_lnum = 0;
    let mut start_col = 0;

    for change in diff.iter_all_changes() {
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

fn edit_to_table<'a>(lua: &'a Lua, edit: &TextEdit) -> LuaResult<LuaTable<'a>> {
    let table = lua.create_table()?;
    table.set("range", range_to_table(lua, &edit.range)?)?;
    table.set("new_text", edit.new_text.clone())?;
    Ok(table)
}

fn range_to_table<'a>(lua: &'a Lua, range: &Range) -> LuaResult<LuaTable<'a>> {
    let table = lua.create_table()?;
    table.set("start", position_to_table(lua, &range.start)?)?;
    table.set("end", position_to_table(lua, &range.end)?)?;
    Ok(table)
}

fn position_to_table<'a>(lua: &'a Lua, position: &Position) -> LuaResult<LuaTable<'a>> {
    let table = lua.create_table()?;
    table.set("line", position.line)?;
    table.set("character", position.character)?;
    Ok(table)
}
