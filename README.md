# HealthService

API:
    - All timestamps are UTC
    - Return start & end of days with data
    - Return types of data
    - Return sources (devices / apps)
    - Return data for a range of time
        - filter on device & data type
        - specify bucket size (day, hour, minute)
        - Returned data 2:
            - Source / Data type / Bucket (timestamp & value)
            { "sources" : [
                { "sourceName": "Shoe",  "deviceName":..., "model":... 
                    "data": [
                        { "type": "flights", 
                            "buckets": [
                                { "time":..., "value":... }
                        ]}, {
                            "type": "distance",
                            "buckets": [ ... ]
                        }
                    ]
                }
            ]}
        - Returned data:
            - Bucket
                - Source/Device
                    - Data type
                        - Value



Data storage:
    - key: <device>-<UTC-timestamp> (day, hour, minute, second?)
        If by hour (day), each document contains multiple records; smaller buckets or range will require filtering

    - start, end date
    - sources
    - each data type
        - flights
        - steps
        - heart rate
        - ...


Health data:
- Steps
- Distance walked or ran
- Flights climbed

Tentative:
- Active energy burned
- Exercise time
- Standing time
- Energy burned
- Heart rate
- Heart rate variability
- Resting heart rate
- Sleep analysis
- Walking heart rate
- VO2 max
- Environment audio exposure
- Headphone audio exposure


## indexing
1. Parse incoming data, output by
    - date (day granularity)
    - type

2. Aggregate parsed data
    - intervals: minute, hour, day, week, year

3. Index aggregated data
    - key: date, time, type, interval
