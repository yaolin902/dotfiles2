return {
  { "eandrju/cellular-automaton.nvim" },
  {
    'dbinagi/nomodoro',
    config = function()
      require('nomodoro').setup({
        work_time = 25,
        short_break_time = 5,
        long_break_time = 15,
        break_cycle = 4,
        texts = {
          on_break_complete = "TIME IS UP!",
          on_work_complete = "TIME IS UP!",
          status_icon = "羽",
          timer_format = '!%0M:%0S' -- To include hours: '!%0H:%0M:%0S'
        },
        on_work_complete = function()
          require("cellular-automaton").start_animation("make_it_rain")
        end,
        on_break_complete = function() end
      })
    end
  },
}
