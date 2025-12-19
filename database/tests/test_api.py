import requests


def test_anonymous_access_is_disabled():
    r = requests.get("http://localhost:3000")
    assert 401 == r.status_code
    assert "PGRST302" == r.json()["code"]
