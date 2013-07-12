-- alert user to enable access for assistive devices
-- grabbed from http://www.macosxautomation.com/applescript/uiscripting/
on GUIScripting_status()
	-- check to see if assistive devices is enabled
	tell application "System Events"
		set UI_enabled to UI elements enabled
	end tell
	if UI_enabled is false then
		tell application "System Preferences"
			activate
			set current pane to pane id "com.apple.preference.universalaccess"
			display dialog "To be able to grab the URL from your default browser you need to \"Enable access for assistive devices\" in the Accessibility preference pane." with icon 1 buttons {"Remove this dialog"} default button 1
		end tell
	end if
end GUIScripting_status
GUIScripting_status()

-- find default browser
-- from http://daringfireball.net/2009/01/applescripts_targetting_safari_or_webkit
on GetDefaultWebBrowser()
	-- First line of _scpt is a workaround for Snow Leopard issues
	-- with 32-bit Mac:: Carbon modules
	set _scpt to "export VERSIONER_PERL_PREFER_32_BIT=yes; " & ¬
		"perl -MMac::InternetConfig -le " & ¬
		"'print +(GetICHelper \"http\")[1]'"
	return do shell script _scpt
end GetDefaultWebBrowser
set _browser to GetDefaultWebBrowser()

-- finally copy URL from active tab of default browser
tell application _browser to activate
tell application "System Events"
	keystroke "l" using {command down}
	keystroke "c" using {command down}
end tell