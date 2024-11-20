use mlua::prelude::*;

mod time;
mod utf;

#[mlua::lua_module]
fn omega_rs(lua: &Lua) -> LuaResult<LuaTable> {
    let exports = lua.create_table()?;

    exports.set(
        "get_timestamp",
        lua.create_function(time::lua_get_timestamp)?,
    )?;
    exports.set(
        "get_human_readable_duration",
        lua.create_function(time::lua_get_human_readable_duration)?,
    )?;
    exports.set("get_chars", lua.create_function(utf::lua_get_chars)?)?;

    Ok(exports)
}
