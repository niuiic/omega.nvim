use mlua::prelude::*;

mod time;

#[mlua::lua_module]
fn omega_rs(lua: &Lua) -> LuaResult<LuaTable> {
    let exports = lua.create_table()?;
    exports.set("get_timestamp", lua.create_function(time::get_timestamp)?)?;
    Ok(exports)
}
