# mem-scan

A command-line tool for monitoring system and GPU memory usage, especially suited for observing memory behavior while running Python programs.

## Features

- **Real-time monitoring of CPU and GPU memory usage**
- **Can monitor the execution of any command**
- **Reports peak, minimum, and average memory usage statistics**
- **Can export reports in JSON format**
- **Configurable monitoring interval and GPU selection**
- **Quiet mode supported**

## Installation

### Install with uv (Recommended)

```bash
# Install from source
uv pip install -e .

# Or install directly
uv pip install mem-scan
```

### Install with pip

```bash
pip install -e .
```

## Dependencies

- `psutil>=5.8.0` - For system memory monitoring
- `pynvml>=11.0.0` - For GPU memory monitoring

## Usage

### Basic Usage

```bash
# Monitor a Python script
mem-scan python your_script.py

# Monitor a Python script with arguments
mem-scan python train.py --batch-size 128 --epochs 10

# Monitor model quantization process
mem-scan python -m modelopt.onnx.quantization --onnx_path=model.onnx --quantize_mode=fp8
```

### Advanced Options

```bash
# Specify GPU device
mem-scan --gpu-id 1 python eval.py

# Set monitoring interval (seconds)
mem-scan --interval 0.05 python train.py

# Output report to file
mem-scan --output memory_report.json python inference.py

# Quiet mode (suppress command output)
mem-scan --quiet --output report.json python benchmark.py

# Show version info
mem-scan --version

# Show help
mem-scan --help
```

## Example Output

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

## JSON Report Example

A report like below will be generated when using the `--output` option:

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

## Development

### Setup

```bash
# Clone the repository
git clone 
cd mem_scan

# Install dev dependencies
uv pip install -e ".[dev]"

# Run tests
pytest

# Code format
black src/ tests/

# Type checking
mypy src/
```

### Build & Publish

```bash
# Build package
uv build

# Publish to PyPI (authentication required)
uv publish
```

## Notes

1. **GPU monitoring requires NVIDIA drivers and the `pynvml` library**

2. **If no GPU or initialization fails, only CPU memory is monitored (with warning)**

3. **Too small interval may impact monitored program's performance**

4. **With `--quiet`, the command output is captured and not shown**

## License

MIT License

## Contributing

Contributions via issues and pull requests are welcome!