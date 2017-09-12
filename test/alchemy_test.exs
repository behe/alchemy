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
end
