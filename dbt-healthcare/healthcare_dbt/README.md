# healthcare_dbt

The dbt project for the [Healthcare Data Platform](../../README.md). It models the Bronze Delta tables in the `healthcare` Unity Catalog into Silver (`staging` views and `intermediate` tables) and a Gold star schema (`marts`).

```bash
dbt deps
dbt build        # models + 20 data tests
```

See the root README for the model list, grain and design choices.
