import pandas as pd
import matplotlib.pyplot as plt



df = pd.read_csv("tempnew.csv")

sensor_cols = df.columns[1:]  


def cusum(series, threshold, drift):
    g_pos = 0
    g_neg = 0
    anomalies = []

    for t in range(1, len(series)):
        St = series[t] - series[t - 1]

        g_pos = max(g_pos + St - drift, 0)
        g_neg = max(g_neg - St - drift, 0)

        if g_pos > threshold or g_neg > threshold:
            anomalies.append(t)
            g_pos = 0
            g_neg = 0

    return anomalies



threshold = 200   
drift = 50      

all_anomalies = {}

for col in sensor_cols:
    series = df[col].tolist()
    anomalies = cusum(series, threshold, drift)
    all_anomalies[col] = anomalies

for col in sensor_cols:
    series = df[col].tolist()
    anomalies = all_anomalies[col]

    plt.figure(figsize=(12,4))
    plt.plot(series, label=col)
    plt.scatter(anomalies, [series[i] for i in anomalies], s=60, marker='o')
    plt.title(f"{col} — CUSUM anomalies")
    plt.xlabel("Sample index")
    plt.ylabel("Temperature ×100")
    plt.grid(True)
    plt.legend()
    plt.show()
