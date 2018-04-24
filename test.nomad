job "test" {
  datacenters = ["dc1"]

  type = "batch"

  periodic {
    cron             = "*/1 * * * * *"
    prohibit_overlap = true
  }

  group "example" {
    reschedule {
      attempts       = 15   # 尝试重新分配次数
      interval       = "1hr" # 从第一次重试开始计时,维持重试的总时间
      delay          = "30s" # 重试失败后等待多久在重试
      delay_function = "exponential" # 重试方法 {constant: 每次重试delay时间不变, exponential:每次重试delay加倍, fibonacci: 每次delay累加}
      max_delay      = "120s" # delay 的延迟上限
      unlimited      = false # 是否无限制的重试
    }

    restart {
      attempts = 15  # 总共重启的次数
      delay    = "15s" # 每次重启失败中间的间隔
      interval = "168h" # 从第一次重启开始计时,维持重启的总时间
      mode     = "fail" # 触发重启的事件 {delay: 调度器调度超时的时候重启(默认), fail: 指示调度程序在失败时不尝试重新启动任务}
    }

    task "service" {
      service {
        check {
          address_mode = "127.0.0.1" #
          type     = "http"
          port     = "lb"
          path     = "/_healthz"
          interval = "5s"
          timeout  = "2s"
          header {
            Authorization = ["Basic ZWxhc3RpYzpjaGFuZ2VtZQ=="]
          }
        }

        check_restart {
          limit = 3  # 当健康检查失败多少次后重启任务
          grace = "90s"  # 检查任务开始或重新启动之前等待健康检查状态的时间
          ignore_warnings = false # - 默认情况下,critical 和warning状态都被认为不健康。设置true则忽略warning状态
        }
      }
    }

    task "run-test" {
      driver = "raw_exec"
      config {
        command = "/Users/vicsoulz/workspace/go/src/test/test.sh"
      }
    }
  }
}