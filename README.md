# تحلیل ریسک بیمه خودرو با استفاده از مدل‌های آماری و داشبورد تحلیلی

## معرفی پروژه

این پروژه با هدف تحلیل عوامل مؤثر بر ریسک بیمه خودرو (Motor Third-Party Liability Insurance) انجام شده است.

در این پروژه، تعداد خسارت‌ها (Claim Frequency) و شدت خسارت‌ها (Claim Severity) مدل‌سازی شده و در نهایت زیان مورد انتظار (Expected Loss) برای هر بیمه‌نامه محاسبه شده است.

ترکیب مدل‌های آماری در R و ابزارهای تحلیل داده در Excel امکان بررسی ریسک از دیدگاه آماری و کسب‌وکاری را فراهم کرده است.


---

# داده‌ها (Dataset)

داده استفاده‌شده مربوط به بیمه مسئولیت مدنی خودرو (Motor Third-Party Liability) است.

ویژگی‌های اصلی داده شامل:

- مشخصات خودرو
- مشخصات راننده
- ویژگی‌های جغرافیایی
- تعداد خسارت‌ها
- مبلغ خسارت‌ها
- میزان Exposure


---

# روش انجام پروژه (Methodology)

## 1. مدل‌سازی فرکانس خسارت (Frequency Modeling)

هدف: پیش‌بینی تعداد مورد انتظار خسارت برای هر بیمه‌نامه.

روش استفاده‌شده:

- Poisson Generalized Linear Model (Poisson GLM)
- استفاده از Exposure به عنوان Offset

خروجی:

- پیش‌بینی تعداد خسارت مورد انتظار
- بررسی عوامل مؤثر بر Frequency


---

## 2. مدل‌سازی شدت خسارت (Severity Modeling)

هدف: بررسی مبلغ متوسط خسارت در صورت وقوع خسارت.

مدل‌های بررسی‌شده:

- Gamma GLM
- Lognormal Regression

مدل‌ها با استفاده از معیارهای خطا روی داده آزمون مقایسه شدند.


---

## 3. محاسبه زیان مورد انتظار (Expected Loss)

Expected Loss از رابطه زیر محاسبه شد:

Frequency × Severity

این معیار برای تخمین ریسک مورد انتظار هر بیمه‌نامه استفاده شد.


---

## 4. تحلیل عوامل ریسک (Risk Factor Analysis)

برای بررسی اهمیت متغیرها از روش‌های زیر استفاده شد:

- Likelihood Ratio Test برای مدل Frequency
- F-test برای مدل Severity
- بررسی ضرایب مدل برای تحلیل جهت رابطه
- تحلیل Expected Loss در گروه‌های مختلف ریسک


---

# تحلیل و داشبورد Excel

در کنار مدل‌سازی آماری، یک داشبورد تحلیلی در Excel توسعه داده شد.

ابزارهای استفاده‌شده:

- Power Query
- Pivot Table
- Pivot Chart
- Power Pivot

قابلیت‌های داشبورد:

- نمایش KPIهای اصلی
- تحلیل Frequency و Severity
- بررسی گروه‌های مختلف ریسک
- فیلتر تعاملی با Slicer


نمونه داشبورد:

مشاهده در پوشه:

`Dashboard`


---

# ساختار پروژه
├── R
│ ├── Frequency Modeling
│ ├── Severity Modeling
│ ├── Model Validation
│ ├── Expected Loss Calculation
│ └── Risk Factor Analysis
│
├── Excel
│ └── Data Analysis and Dashboard Description
│
└── Dashboard
└── Dashboard Preview



---

# ابزارهای استفاده‌شده

- R
- RStudio
- Excel
- Power Query
- Power Pivot
- Pivot Table


---

# هدف یادگیری و کاربرد

این پروژه با تمرکز بر کاربردهای علم داده در صنعت بیمه انجام شده و شامل مراحل اصلی یک فرآیند تحلیل ریسک بیمه‌ای از آماده‌سازی داده تا مدل‌سازی، ارزیابی و ارائه نتایج است.
