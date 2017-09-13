defmodule AlchemyTest do
  use ExUnit.Case

  test "parse xml to struct discarding attributes" do
    xml = "
    <?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>
    <error>
        <code id=\"1032\">USER_MULTIPLE_VALIDATION_ERRORS</code>
        <reference>6d31554e5b389cb8</reference>
        <errors>
            <error>
                <code id=\"1026\">USER_INVALID_EMAIL</code>
                <description>Email address is already registered</description>
                <reference>cc759f91c8e95fd2</reference>
            </error>
            <error>
                <code id=\"1024\">USER_INVALID_USERNAME</code>
                <description>Username is already registered</description>
                <reference>3b0727a55e165336</reference>
            </error>
        </errors>
    </error>"

    assert Alchemy.parse(xml) == %{
      "error" => %{
        "code" => "USER_MULTIPLE_VALIDATION_ERRORS",
        "reference" => "6d31554e5b389cb8",
        "errors" => [
          %{
            "error" => %{
              "code" => "USER_INVALID_EMAIL",
              "description" => "Email address is already registered",
              "reference" => "cc759f91c8e95fd2",
            }
          },
          %{
            "error" => %{
              "code" => "USER_INVALID_USERNAME",
              "description" => "Username is already registered",
              "reference" => "3b0727a55e165336",
            }
          },
        ]
      }
    }
  end

  test "parse" do
    xml = "
    <?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>
    <user>
      <dateOfBirth>1977-01-01T01:00:00+01:00</dateOfBirth>
      <email>test_63672443684@example.test</email>
      <emailStatus>2</emailStatus>
      <firstName>Rök</firstName>
      <id>65188401</id>
      <lastName>Test</lastName>
      <mobileStatus>0</mobileStatus>
      <properties/>
      <registrationDate>2017-09-12T15:55:46.300+02:00</registrationDate>
      <userName>test_63672443684@example.test</userName>
      <zip>12345</zip>
    </user>"

    assert Alchemy.parse(xml) == %{
      "user" => %{
        "dateOfBirth" => "1977-01-01T01:00:00+01:00",
        "email" => "test_63672443684@example.test",
        "emailStatus" => "2",
        "firstName" => "Rök",
        "id" => "65188401",
        "lastName" => "Test",
        "mobileStatus" => "0",
        "properties" => [],
        "registrationDate" => "2017-09-12T15:55:46.300+02:00",
        "userName" => "test_63672443684@example.test",
        "zip" => "12345"
      }
    }
  end
end
