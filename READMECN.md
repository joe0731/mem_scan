以下是 mem-scan 工具的中英文双语简介、安装与用法说明，专为系统与 GPU 内存监控优化内容编排：

# mem-scan

一个用于监控系统和 GPU 内存使用情况的命令行工具，特别适用于监控 Python 程序执行期间的内存特征。

A command-line tool for monitoring system and GPU memory usage, especially suited for observing memory behavior while running Python programs.

## 功能特性 Features

- **实时监控 CPU 内存和 GPU 内存使用情况**  
  Real-time monitoring of CPU and GPU memory usage

- **支持监控任意命令的执行过程**  
  Can monitor the execution of any command

- **提供峰值、最小值和平均值统计**  
  Reports peak, minimum, and average memory usage statistics

- **支持将报告保存为 JSON 格式**  
  Can export reports in JSON format

- **可配置监控间隔和 GPU 设备**  
  Configurable monitoring interval and GPU selection

- **支持静默模式执行**  
  Quiet mode supported

## 安装 Installation

### 使用 uv 安装（推荐）  
Install with uv (Recommended)

```bash
# 从源码安装 / Install from source
uv pip install -e .

# 或者直接安装 / Or install directly
uv pip install mem-scan
```

### 使用 pip 安装  
Install with pip

```bash
pip install -e .
```

## 依赖项 Dependencies

- `psutil>=5.8.0` - 系统内存监控 / For system memory monitoring
- `pynvml>=11.0.0` - GPU 内存监控 / For GPU memory monitoring

## 使用方法 Usage

### 基本用法 Basic Usage

```bash
# 监控 Python 脚本执行 / Monitor a Python script
mem-scan python your_script.py

# 监控带参数的命令 / Monitor a Python script with arguments
mem-scan python train.py --batch-size 128 --epochs 10

# 监控模型量化过程 / Monitor model quantization process
mem-scan python -m modelopt.onnx.quantization --onnx_path=model.onnx --quantize_mode=fp8
```

### 高级选项 Advanced Options

```bash
# 指定 GPU 设备 / Specify GPU device
mem-scan --gpu-id 1 python eval.py

# 调整监控间隔 / Set monitoring interval (seconds)
mem-scan --interval 0.05 python train.py

# 保存报告到文件 / Output report to file
mem-scan --output memory_report.json python inference.py

# 静默模式 / Quiet mode (suppress command output)
mem-scan --quiet --output report.json python benchmark.py

# 查看版本信息 / Show version info
mem-scan --version

# 查看帮助信息 / Show help
mem-scan --help
```

## 输出示例 Example Output

```
Starting memory monitoring for: python train.py --batch-size 128
GPU ID: 0, Interval: 0.1s
------------------------------------------------------------

============================================================
MEMORY USAGE REPORT
============================================================
Execution Time: 45.32 seconds
Return Code: 0

GPU Memory Usage:
  Peak: 8.45 GB
  Min:  0.12 GB
  Avg:  6.78 GB

Host Memory Usage:
  Peak: 12.34 GB
  Min:  8.90 GB
  Avg:  10.45 GB

Report saved to: memory_report.json
```

## JSON 报告格式 JSON Report Example

使用 `--output` 参数时会生成 JSON 格式的报告/ A report like below will be generated when using the `--output` option:

```json
{
  "execution_time": 45.32,
  "return_code": 0,
  "memory_usage": {
    "gpu_peak_gb": 8.45,
    "gpu_min_gb": 0.12,
    "gpu_avg_gb": 6.78,
    "host_peak_gb": 12.34,
    "host_min_gb": 8.90,
    "host_avg_gb": 10.45
  },
  "command": "python train.py --batch-size 128",
  "timestamp": "2024-01-20 14:30:45"
}
```

## 开发 Development

### 开发环境设置 Setup

```bash
# 克隆仓库 / Clone the repository
git clone 
cd mem_scan

# 使用 uv 安装开发依赖 / Install dev dependencies
uv pip install -e ".[dev]"

# 运行测试 / Run tests
pytest

# 代码格式化 / Code format
black src/ tests/

# 类型检查 / Type checking
mypy src/
```

### 构建和发布 Build & Publish

```bash
# 构建包 / Build package
uv build

# 发布到 PyPI（需配置认证）/ Publish to PyPI (authentication required)
uv publish
```

## 注意事项 Notes

1. **GPU 监控需安装 NVIDIA 驱动和 `pynvml`**  
   GPU monitoring requires NVIDIA drivers and the `pynvml` library

2. **无 GPU 或无法初始化时，仍监控 CPU 内存**  
   If no GPU or initialization fails, only CPU memory is monitored (with warning)

3. **过短监控间隔可能影响目标程序性能**  
   Too small interval may impact monitored program's performance

4. **静默模式下被监控程序输出会被捕获但不显示**  
   With `--quiet`, the command output is captured and not shown

## 许可证 License

MIT License

## 贡献 Contributing

欢迎提交 Issue 和 Pull Request！  
Contributions via issues and pull requests are welcome!
