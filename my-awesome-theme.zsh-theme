# my-awesome-theme.zsh-theme (Version 2 with Mamba/Conda support)

# 函数：获取本地 IP 地址
# 针对 macOS 和 Linux 提供了不同的获取方式
function get_local_ip() {
  local ip
  # 检查操作系统
  case "$(uname -s)" in
    Darwin)
      # macOS: 优先获取 Wi-Fi (en0) 的 IP，如果不存在则尝试以太网 (en1)
      ip=$(ipconfig getifaddr en0 || ipconfig getifaddr en1)
      ;;
    Linux)
      # Linux: 获取第一个非本地回环的 IP 地址
      ip=$(hostname -I | awk '{print $1}')
      ;;
    *)
      ip="unknown_os"
      ;;
  esac
  echo "$ip"
}

# 新增函数：获取当前 Mamba/Conda 虚拟环境名称
# 如果环境被激活，则返回格式化的名称；否则返回空字符串。
function mamba_prompt_info() {
  if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    # 如果 $CONDA_DEFAULT_ENV 变量存在且不为空
    echo -n "%F{blue} (🐍 ${CONDA_DEFAULT_ENV})%f"
  fi
}

# 主题的 PROMPT 设置
# PROMPT 变量定义了左侧提示符的样式
# %F{...} 和 %f 用于设置颜色
# %n 显示用户名
# %~ 显示当前路径
# $(mamba_prompt_info) 调用函数获取 Mamba 环境信息
# $(git_prompt_info) 调用 Oh My Zsh 内置函数获取 Git 信息

PROMPT='%F{cyan}%n%f@%F{green}$(get_local_ip)%f in %F{yellow}%~%f$(mamba_prompt_info) $(git_prompt_info)%f'$'\n'$'› '

# Git 提示符信息的自定义
# ZSH_THEME_GIT_PROMPT_PREFIX 设置 Git 信息的前缀
# ZSH_THEME_GIT_PROMPT_SUFFIX 设置后缀
# ZSH_THEME_GIT_PROMPT_DIRTY 表示有未提交的更改
# ZSH_THEME_GIT_PROMPT_CLEAN 表示工作目录是干净的

ZSH_THEME_GIT_PROMPT_PREFIX="on %F{magenta}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""