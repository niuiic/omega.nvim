use std::time::Duration;

use chrono::{Local, NaiveDateTime};
use humantime::format_duration;
use mlua::prelude::*;

// % get_timestamp %
pub fn lua_get_timestamp(_: &Lua, time: Option<String>) -> LuaResult<i64> {
    get_timestamp(time)
}

fn get_timestamp(time: Option<String>) -> LuaResult<i64> {
    if time.is_none() {
        return Ok(Local::now().timestamp_millis());
    }

    let native_date_time = NaiveDateTime::parse_from_str(&time.unwrap(), "%Y-%m-%d %H:%M:%S")
        .map_err(|_| mlua::Error::RuntimeError("invalid time format".to_string()))?;
    Ok(native_date_time
        .and_local_timezone(Local::now().timezone())
        .unwrap()
        .timestamp_millis())
}

// % get_human_readable_duration %
pub fn lua_get_human_readable_duration(_: &Lua, time: (i64, i64)) -> LuaResult<String> {
    get_human_readable_duration(time.0, time.1)
}

fn get_human_readable_duration(start: i64, end: i64) -> LuaResult<String> {
    if start > end {
        return Err(mlua::Error::RuntimeError(
            "start time is after the end time".to_string(),
        ));
    }

    let duration = Duration::from_millis((end - start) as u64);

    Ok(format_duration(duration).to_string())
}

// % test %
#[cfg(test)]
mod test {
    use chrono::DateTime;

    use super::*;

    #[test]
    fn test_get_timestamp() {
        let now = get_timestamp(None).unwrap();
        let now_str = DateTime::from_timestamp_millis(now)
            .unwrap()
            .with_timezone(&Local::now().timezone())
            .format("%Y-%m-%d %H:%M:%S")
            .to_string();
        assert_eq!(
            (get_timestamp(Some(now_str)).unwrap() - now).abs() < 1000,
            true
        );
    }

    #[test]
    fn test_get_human_readable_duration() {
        let res = &get_human_readable_duration(1729515061307, 1729515071307).unwrap();
        assert_eq!(res, "10s");
    }
}
