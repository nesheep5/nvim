return {
  'ojroques/nvim-osc52',
  config = function()
   vim.api.nvim_create_autocmd('TextYankPost', {callback = function()
     if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
       require('osc52').copy_register('')
     end
   end })
  end
}
