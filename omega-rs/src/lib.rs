use mlua::prelude::*;

mod diff;
mod time;

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
    exports.set("diff_text", lua.create_async_function(diff::lua_diff_text)?)?;
    Ok(exports)
}
