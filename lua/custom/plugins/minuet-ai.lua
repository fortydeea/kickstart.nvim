return {
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      -- Prompt example from prompt.md
      local gemini_prompt = require('minuet.config').default_system_prefix_first.prompt

      local gemini_few_shots = {}

      gemini_few_shots[1] = {
        role = 'user',
        content = [[
      # language: javascript
      <contextBeforeCursor>
      function transformData(data, options) {
          const result = [];
          for (let item of data) {
              <cursorPosition>
      <contextAfterCursor>
          return result;
      }

      const processedData = transformData(rawData, {
          uppercase: true,
          removeSpaces: false
      });]],
      }

      local gemini_chat_input_template =
        '{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}'

      gemini_few_shots[2] = require('minuet.config').default_few_shots[2]

      require('minuet').setup {
        -- Your configuration options here
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = '<A-A>',
            -- accept one line
            accept_line = '<A-a>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-]>',
            dismiss = '<A-e>',
          },
        },
        provider = 'gemini',
        provider_options = {
          model = 'gemini-2.0-flash',
          system = {
            prompt = gemini_prompt,
          },
          few_shots = gemini_few_shots,
          chat_input = {
            template = gemini_chat_input_template,
          },
          stream = true,
          api_key = 'GEMINI_API_KEY',
          end_point = 'https://generativelanguage.googleapis.com/v1beta/models',
          optional = {
            generationConfig = {
              maxOutputTokens = 256,
              -- When using `gemini-2.5-flash`, it is recommended to entirely
              -- disable thinking for faster completion retrieval.
              thinkingConfig = {
                thinkingBudget = 0,
              },
            },
          },
        },
      }
    end,
  },
}
