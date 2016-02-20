defmodule GameEngine.AllowCrossDomainRequestsPlugTest do
    use ExUnit.Case, async: true
    use Plug.Test

    @options GameEngine.AllowCrossDomainRequestsPlug.init([])

    @allow_cross_origin "access-control-allow-origin"
    @allow_headers "access-control-allow-headers"
    @allow_methods "access-control-allow-methods"

    test "game engine allows cross-domain requests" do
        conn = conn(:post, "/move")

        conn = GameEngine.AllowCrossDomainRequestsPlug.call(conn, @options)

        assert get_resp_header(conn, @allow_cross_origin) == ["*"]
    end

    test "game engine allows http headers when request are cross-domain" do
        conn = conn(:post, "/move")

        conn = GameEngine.AllowCrossDomainRequestsPlug.call(conn, @options)

        assert get_resp_header(conn, @allow_headers) == ["content-type, access-control-allow-headers, authorization, x-requested-with"]
    end

    test "game engine allows all http methods when request are cross-domain" do
        conn = conn(:post, "/move")

        conn = GameEngine.AllowCrossDomainRequestsPlug.call(conn, @options)

        assert get_resp_header(conn, @allow_methods) == ["get, post, put, delete, options"]
    end

end
