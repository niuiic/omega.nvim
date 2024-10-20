use chrono::{DateTime, NaiveDateTime, Utc};
use mlua::prelude::*;

pub fn get_timestamp(_: &Lua, date: Option<String>) -> LuaResult<i64> {
    _get_timestamp(date)
}

fn _get_timestamp(date: Option<String>) -> LuaResult<i64> {
    if date.is_none() {
        let now = Utc::now();
        return Ok(now.timestamp_millis());
    }

    let date_str = &date.unwrap();
    let native_date_time = NaiveDateTime::parse_from_str(date_str, "%Y-%m-%d %H:%M:%S")
        .map_err(|_| mlua::Error::RuntimeError("invalid date format".to_string()))?;
    let time = DateTime::<Utc>::from_naive_utc_and_offset(native_date_time, Utc);
    Ok(time.timestamp_millis())
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_get_timestamp() {
        _get_timestamp(None).unwrap();
        _get_timestamp(Some("2022-01-01 00:00:00".to_string())).unwrap();
    }
}
