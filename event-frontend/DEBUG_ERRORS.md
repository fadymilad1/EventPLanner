# Debugging 400/500 Errors

## How to See Full Error Details

### In Browser Console:

1. **Open Browser Console** (F12)
2. **Look for the error logs:**
   - `Create event error: HttpErrorResponse`
   - `Failed to load invited events: HttpErrorResponse`

3. **Expand the error object** to see:
   - `error.error` - The actual error response from server
   - `error.status` - HTTP status code
   - `error.statusText` - Status text

4. **Check the "Form data before submit" log** to see what data is being sent

### Common Issues:

#### 400 Bad Request on Create Event:

**Possible causes:**
1. **Date format issue** - Date must be YYYY-MM-DD
2. **Time format issue** - Time must be HH:MM (24-hour)
3. **Missing required field** - Title, date, time, or location is empty
4. **Validation error** - Field doesn't meet requirements

**Check:**
- Look at "Form data before submit" log
- Check `error.error.message` in console
- Check `error.error.errors` for validation errors
- Check `error.error.missingFields` for missing fields

#### 500 Internal Server Error on Invited Events:

**Possible causes:**
1. **Database column missing** - `event_date` or other columns don't exist
2. **SQL syntax error** - Query has an issue
3. **Database connection issue**

**Check backend console** for detailed error:
- Look for `=== Get Invited Events Error ===`
- Check error code and message

## Quick Fixes:

### For 400 Error:
1. Make sure date is in YYYY-MM-DD format
2. Make sure time is in HH:MM format (24-hour)
3. Fill all required fields
4. Check browser console for specific validation errors

### For 500 Error:
1. Check backend console for error details
2. Run the database fix script in pgAdmin
3. Verify database tables have all columns

