# Edge Tool Suite

The Edge Tool Suite are a set of OHDSI tools that should be deployed by the site that provide value around the OMOP CDM.  
The OHDSI open source software configured for deployment include:
- The Atlas data science platform
- The WebAPI backed for Atlas
- The HADES statistical analysis packages
- The Data Quality Dashboard
- The Perseus ETL management system

## Simplifying the ETL process

The OHDSI community has created a series of individual software packages to facilitate the 
ETL from proprietary EHRs to OMOP, evaluate data quality, define cohorts, and perform 
analyses. The “Edge Tool” packages these individual tools to facilitate the performance of an 
OMOP ETL and subsequent use of the data for defining cohorts for observational research. In 
contrast to registry approaches which ingest data represented in various data models and 
perform data harmonization centrally, software components of the “Edge Tool” facilitate ETL 
performance locally at the “edge.” This suite of software aims to drastically reduce the labor and 
effort required to go from “zero to OMOP.” We anticipate that institutions that use the full suite 
of offered software will be able to reduce the person-hours required for an OMOP ETL to as little 
as 50 hours.

## Software components
The Edge Tool encompasses the Perseus ETL management solution, the HADES R analysis 
package within an RStudio Server R integrated development environment, and the ATLAS 
cohort discovery tool with WebAPI web services integration (Figure). 
The Perseus graphic-user interface (GUI) approach provides source-to-concept mapping for the 
ETL, with assisted extraction of data from EHR such as flowsheets (vital signs, nursing 
assessments), test measurements, and diagnoses. Rather than performing a series of SQL 
queries with wildcards to identify data elements of interest from primary source EHR tables, 
users may enter desired data element terms into a browser text field which are then matched 
using term similarity to source table entries. 

Users may then evaluate the completeness and quality of the ETL using the Data Quality 
Dashboard which performs >3,000 individual data quality checks on the OMOP-formatted data 
and is reported through a web-based reporting system.
In tandem with Perseus, OHDSI HADES and OHDSI ATLAS are the two projects within the 
Edge Tool that allow for advanced analysis once data has been harmonized with the OMOP 
CDM, such as generating cohorts for research, patient level prediction, treatment pathways, 
large scale population analytics, automated reporting and, optionally, participation in OHDSI 
network studies. 

The OHDSI applications within the Edge Tool have been containerized using OHDSI Broadsea, 
allowing for even easier deployment. Current use of the Edge Tool has proven promising and 
while limitations still exist - e.g., not currently capable of extracting data from unstructured fields 
such as notes or loose text - further process optimization and tool development will reduce this 
implementation time and effort further.

## Ways to deploy the software

### 1. Cloud vendors can deploy the software configured for use.

### 2. Broadsea provides a set of docker containers that easy the cost of implementation

### 3. Sites can compile the tools from the source repositories
OHDSI Specific
• https://github.com/OHDSI/CommonDataModel
• https://github.com/OHDSI/Broadsea
• https://github.com/OHDSI/Athena
Perseus and the ETL Process
• https://github.com/OHDSI/Perseus
• https://github.com/OHDSI/WhiteRabbit
• https://github.com/OHDSI/Usagi
ATLAS and Cohort Discovery
• https://github.com/OHDSI/Atlas
• https://github.com/OHDSI/WebAPI
Data Analysis
• https://github.com/OHDSI/Achilles
• https://github.com/OHDSI/Hades
• https://github.com/OHDSI/PatientLevelPrediction
• https://github.com/OHDSI/DataQualityDashboar
5. 
