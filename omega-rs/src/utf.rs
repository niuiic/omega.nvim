use mlua::prelude::*;

// % get_chars %
pub fn lua_get_chars(_: &Lua, str: String) -> LuaResult<Vec<String>> {
    Ok(get_chars(str))
}

fn get_chars(str: String) -> Vec<String> {
    str.chars()
        .map(|char| char.to_string())
        .collect::<Vec<String>>()
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_get_chars() {
        let chars = get_chars("你好，世界".to_string());
        assert_eq!(chars[0], "你");
    }
}
