# Search result fetcher

This tool fetches the first 100 search results for a fixed set of queries
and saves them to a CSV file.

These CSV files are intended to be easily diffable, to highlight unexpected changes
in search results following an upgrade.

### Dependencies

- [alphagov/plek]() - locates the rummager service

### Running the application

`govuk_setenv default bundle exec bin/search-result-fetcher search_queries /path/to/output.csv`

This will generate a CSV file that looks like this:

```
query,position,description,format,link,organisations,public_timestamp,specialist_sectors,title,index,es_score,_id,document_type
contact,1,"Contact details and helplines for enquiries with HMRC on tax, Self Assessment, Child Benefit or tax credits",answer,/contact-hmrc,1,2014-11-24T15:26:43+00:00,1,Contact HMRC,restored-mainstream,78664.22,/contact-hmrc,edition
contact,2,Contact details for UK Visas and Immigration (UKVI) for people inside the UK,guide,/contact-ukvi,1,2014-11-18T12:18:42+00:00,Contact UK Visas and Immigration from inside the UK,restored-mainstream,65553.51,/contact-ukvi,edition
contact,3,"Contact UKVI via email, telephone or webchat if you're outside the UK",transaction,/contact-ukvi-outside-uk,1,Contact UK Visas and Immigration from outside the UK,restored-mainstream,52442.81,/contact-ukvi-outside-uk,edition
contact,4,"Contact Her Majesty's Passport Office (previously the Identity and Passport Service) advice line - telephone, text relay, textphone, opening hours",answer,/passport-advice-line,1,2015-05-11T16:35:11+01:00,Passport advice and complaints,restored-mainstream,39332.105,/passport-advice-line,edition
contact,5,"Contact details for Student Finance England - including complaints and student finance appeals, 24+ Advanced Learning Loans",answer,/contact-student-finance-england,2,2015-02-25T14:38:43+00:00,Contact Student Finance England,restored-mainstream,26221.408,/contact-student-finance-england,edition
contact,6,"Find the right number, email or address to contact DVLA about driving licences, vehicle tax, medical enquiries, complaints and vehicle registration
",simple_smart_answer,/contact-the-dvla,1,2015-03-03T11:47:42+00:00,Contact DVLA,restored-mainstream,0.01097993,/contact-the-dvla,edition
contact,7,"Jobcentre Plus contact details for claims, appointments, help finding a job and checking local Jobcentre Plus opening hours",answer,/contact-jobcentre-plus,1,2015-01-30T17:07:02+00:00,Contact Jobcentre Plus,restored-mainstream,0.006684235,/contact-jobcentre-plus,edition
contact,8,Find a job using the Universal Jobmatch service - jobseekers can match their CV and skills to jobs posted by companies,transaction,/jobsearch,1,2014-11-26T11:26:56+00:00,Find a job with Universal Jobmatch,restored-mainstream,0.0019232947,/jobsearch,edition
```

* Each row in the CSV is a search result.
* The first two columns in the CSV contain the search query the result belongs to followed by the ranking.
* The remaining columns correspond to the default fields returned by the rummager API.

### Use cases

#### Verifying search results are unchanged during a deployment

```
# Clone the repo
git clone git@github.com:alphagov/search-result-fetcher.git
cd search-result-fetcher

# Fetch the results before
bundle exec ./bin/search_result_fetcher search_queries before.csv

# Deploy the update

# Fetch the results after
bundle exec ./bin/search_result_fetcher search_queries after.csv

# Compare
diff before.csv after.csv
```

## Licence

[MIT License](LICENCE)
