-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt.settings.connection = "disconnected"
flexprompt.settings.lines = "two"
flexprompt.settings.symbols =
{
    prompt =
    {
        ">",
        winterminal = "❯",
    },
}
flexprompt.settings.heads = "flat"
flexprompt.settings.separators = "bar"
flexprompt.settings.frame_color = "darkest"
flexprompt.settings.right_prompt = "{exit}{duration}{time:format=%H:%M:%S}"
flexprompt.settings.tails = "flat"
flexprompt.settings.flow = "fluent"
flexprompt.settings.left_prompt = "{battery}{cwd}{git}"
flexprompt.settings.charset = "unicode"
flexprompt.settings.style = "classic"
flexprompt.settings.spacing = "sparse"
flexprompt.settings.right_frame = "none"
flexprompt.settings.left_frame = "none"
flexprompt.settings.use_8bit_color = true
