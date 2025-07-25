#!/usr/bin/env python3
"""
Simple test script for memory monitoring
"""

import time
import numpy as np

def main():
    print("Starting test script...")
    
    # allocate some memory
    print("Allocating memory...")
    arrays = []
    for i in range(5):
        # allocate 100MB arrays
        arr = np.random.rand(100 * 1024 * 1024 // 8)  # 100MB
        arrays.append(arr)
        print(f"Allocated array {i+1}/5")
        time.sleep(1)
    
    print("Holding memory for 3 seconds...")
    time.sleep(3)
    
    print("Releasing memory...")
    del arrays
    
    print("Test completed!")

if __name__ == "__main__":
    main() 