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
    exports.set(
        "calc_text_edits",
        lua.create_function(diff::calc_text_edits)?,
    )?;
    Ok(exports)
}
