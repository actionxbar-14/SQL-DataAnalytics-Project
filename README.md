# SQL Data Analytics Project


```
sql-data-analytics-project/
├── 00_setup/                        the setup guide, and the one-click Docker start for Mac
├── 01_datasets/                     the data, as a backup and as CSV files
│   ├── DataWarehouseAnalytics.bak   the database, ready to restore
│   └── csv-files/                   the same data, to build the database yourself
├── 02_docs/                         the project roadmap and notes
└── 03_scripts/                      the queries, in the order of the videos
    └── 00_init_database.sql         builds the database from the CSV files
```

Get the database in one of two ways:

- Restore `01_datasets/DataWarehouseAnalytics.bak` in SSMS. It needs SQL Server 2022 or newer.
- Or run `03_scripts/00_init_database.sql`. It builds the database from the CSV files in `C:\sql\sql-data-analytics-project\01_datasets\csv-files\`.

The videos show the folders without numbers: `datasets` there is `01_datasets` here, `scripts` is `03_scripts`.

---

## 🗺️ What you build

![The project roadmap]<img width="2141" height="916" alt="Project Roadmap" src="https://github.com/user-attachments/assets/e2aa2251-37a9-4cd8-a7ec-63e2d3be95cd" />


The project has two parts, and the scripts follow them:

- **Exploratory data analysis**, scripts `01` to `06`: you get to know the data, from the tables and dates to the big numbers and the top performers.
- **Advanced analytics**, scripts `07` to `13`: you go deeper with trends, running totals, performance, part-to-whole and segments. Two reports close the project, one for customers and one for products.

---

## 🛡️ License

[MIT](LICENSE). Use it, change it, share it, with attribution.

## 🌟 About me

Hi, I'm **Anubhav Pathak**.  
