# Experimental Spectral Bifurcation

This repository contains code for generating **spectral bifurcation diagrams (SBD)** using both experimental data (DAQ-based) and numerical simulations.

---

## 🔬 Workflow

The complete pipeline is:

Circuit → DAQ → Time-series → FFT → Spectral Bifurcation Diagram

---

## 📂 Files Description

### 1. `Daq_code.ipynb`
- Python notebook for:
  - DAQ-based parameter sweep
  - Time-series data acquisition
  - Saving data in CSV format

---

### 2. `Experimental SBD.m`
- MATLAB code for:
  - Processing experimental time-series data
  - Performing FFT analysis
  - Generating spectral bifurcation diagram

---

### 3. `Numerical SBD.m`
- MATLAB code for:
  - Simulating dynamical system (e.g., Rössler)
  - Generating numerical spectral bifurcation diagram

---

## ⚙️ Requirements

### Python:
- numpy
- matplotlib
- nidaqmx

### MATLAB:
- Signal processing (FFT)

---

## 🚀 How to Use

1. Run `Daq_code.ipynb` to acquire experimental data  
2. Use `Experimental SBD.m` to generate experimental SBD  
3. Use `Numerical SBD.m` for comparison with simulation  

---

## 👤 Authors
Suvradip Maity and Debajyoti Guha

