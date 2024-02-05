if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    #Remove rows where the passenger count is equal to 0 or the trip distance is equal to zero.
    transformed_data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)].copy()

    #Create a new column lpep_pickup_date by converting lpep_pickup_datetime to a date.
    transformed_data['lpep_pickup_date'] = transformed_data['lpep_pickup_datetime'].dt.date

    #Rename columns in Camel Case to Snake Case, e.g. VendorID to vendor_id.
    transformed_data.rename(columns={
        "VendorID": "vendor_id", 
        "RatecodeID": "ratecode_id",
        "PULocationID": "pu_location_id", 
        "DOLocationID": "do_location_id",
    }, inplace=True)
    
    return transformed_data


@test
def test_passanger_count(output, *args) -> None:
    assert output['passenger_count'].isin([0]).sum() == 0

@test
def test_trip_distance(output, *args) -> None:
    assert output['trip_distance'].isin([0]).sum() == 0

@test
def test_vendor_id(output, *args) -> None:
    assert output['vendor_id'].isin([1,2]).unique()[0]