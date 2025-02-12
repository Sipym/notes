# lazy.nvim Plugin Spec
> :bulb: **<font color = red>下面单独的每一个选项，都可以在nvim插件配置中作为一行列出</font>:**
```lua
return {
   {
      -- 对于插件来源
      "folke/tokyonight.nvim",
      --> dir = "",
      --> url = "",
      --> dev = true/false,
      --> ...

      -- 对于lazy loading
      lazy = true,
      --> event,cmd,ft,keys

      init = ...,
      opts = ...,
      config = ...,
      main = ...,
      build = ...,
      -- 等等


   }
}
```
## 插件来源
1.  **[1]**: 简短的插件网址  
      ```lua
      { "folke/tokyonight.nvim", }
      ```

2. **dir**: 指向本地插件的文件路径  
   ```lua
   { dir = "~/projects/secret.nvim" },
   ```

3. **url**: 插件的 Git 仓库地址
   ```lua
   { url = "git@github.com:folke/noice.nvim.git" },
   ```

4. **name**: 

5. **dev**: 当dev=true时，用本地的插件版本,而不是Github中的，<font color = red>适合用于开发插件</font>。  
   ```lua
   { "folke/noice.nvim", dev = true },
   ```

## lazy loading
1. **lazy = true**: 按需加载  

2. **event**: 根据事件来加载,[参考](https://neovim.io/doc/user/autocmd.html#_5.-events)
   ```lua
   -- 当进入插入模式时，加载该插件
   {
      "hrsh7th/nvim-cmp",
      -- load cmp on InsertEnter
      event = "InsertEnter",
    },
   ```

3. **cmd**: 执行特定命令的时候，才加载该插件。  
   ```lua
   {
     "dstein64/vim-startuptime",
     -- lazy-load on a command
     cmd = "StartupTime",
   },
   ```

4. **ft**: 打开对应文件类型的时候加载  
   ```lua
   {
     "nvim-neorg/neorg",
     -- lazy-load on filetype
     ft = "norg",
   }
   ```

5. **keys**:<font color = red>按下特定键的时候，加载该插件</font>   
   - > param1 (required): `lhs`
   - > param2 (optional): `rhs`
   - > param3 (optional): **mode**, 默认值是"n"  
   - > param4 (optional): 
   - > ... : <font color = red>其他任何`vim.keymapl.set`中有的参数</font>  

   - > :bulb: <font color = green>键映射将在第一次执行时加载插件。当`param2`为零时，真正的映射必须由 config() 函数创建</font>  
   ```lua
   {
     "nvim-neo-tree/neo-tree.nvim",
       keys = {
         { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
       },
       opts = {},
   }
   ```

## 插件配置规范



1. **init**: fun类型, <font color = darkred>在插件首次启动时加载</font>，主要用于在插件启动时配置`vim.g.*`  
   ```lua
   {
      "dstein64/vim-startuptime",
      -- init is called during startup. Configuration for vim plugins typically should be set in an init function
      init = function()
        vim.g.startuptime_tries = 10
      end,
   },
   ```

2. **opts**: <font color = blue>是一个表</font>，它将被传递给插件的配置函数 Plugin.config()，并且可以在加载插件时用来合并或替代默认配置。  
   - > :star: **<font color = darkred>推荐用于插件配置</font>**,<font color = red>只能配置该插件的参数</font>  
   ```lua
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            win = {
                -- don't allow the popup to overlap with the cursor
                no_overlap = true,
            },
            layout = {
                width = { min = 20 }, -- min and max width of the columns
                spacing = 3,          -- spacing between columns
            },
        },
    },
   ```

3. **config**: 当插件被加载时执行。当`opts`或`config = true`被设置，将会默认自动执行`require(XX).setup(opts)`  
   - > :star: <font color = red>config 主要用于配置和执行额外的初始化工作，而 opts 是用来提供配置参数</font>  
      - > 如果插件已经支持 opts 作为配置方式，config 可以用来执行一些额外的操作，**<font color = red>例如设置 vim 选项、初始化其他模块等</font>**。


> :bulb: **<font color = green>summary</font>**: opts只能插件本身的选项/变量进行配置. config可以配置vim的选项，变量，以及调用其他配置函数等等  

4. **main**: ..
5. **build**:...


**重点**: <font color = skyblue>对于require.setup()和opts 的区别</font>  
   - > 通过opts传递插件配置时，<font color = red>配置会在插件加载完成之后才传递给插件</font>。这意味着，插件的初始化过程不会立即应用这些设置，而是等插件加载后，opts 中的配置会作为插件的初始化参数传递  
   - > 通过require().setup()，<font color = red>会在插件加载时立即传递配置参数</font>，适合于主题插件。  

