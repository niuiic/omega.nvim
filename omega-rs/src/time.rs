use std::time::Duration;

use chrono::{DateTime, NaiveDateTime, Utc};
use humantime::format_duration;
use mlua::prelude::*;

// % get_timestamp %
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

// % get_human_readable_duration %
pub fn get_human_readable_duration(_: &Lua, time: (i64, i64)) -> LuaResult<String> {
    _get_human_readable_duration(time.0, time.1)
}

fn _get_human_readable_duration(start: i64, end: i64) -> LuaResult<String> {
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
    use super::*;

    #[test]
    fn test_get_timestamp() {
        _get_timestamp(None).unwrap();
        _get_timestamp(Some("2022-01-01 00:00:00".to_string())).unwrap();
    }

    #[test]
    fn test_get_human_readable_duration() {
        let res = &_get_human_readable_duration(1729515061307, 1729515071307).unwrap();
        assert_eq!(res, "10s");
    }
}
