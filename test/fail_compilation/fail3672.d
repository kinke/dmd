/*
TEST_OUTPUT:
---
fail_compilation/fail3672.d(27): Error: read-modify-write operations are not allowed for `shared` variables. Use `core.atomic.atomicOp!"+="(*p, 1)` instead.
fail_compilation/fail3672.d(31): Error: read-modify-write operations are not allowed for `shared` variables. Use `core.atomic.atomicOp!"+="(*sfp, 1)` instead.
---
*/

struct SF  // should fail
{
    void opOpAssign(string op, T)(T rhs)
    {
    }
}

struct SK  // ok
{
    void opOpAssign(string op, T)(T rhs) shared
    {
    }
}

void main()
{
    shared int x;
    auto p = &x;
    *p += 1;  // fail

    shared SF sf;
    auto sfp = &sf;
    *sfp += 1;  // fail

    shared SK sk;
    auto skp = &sk;
    sk += 1;  // ok
    *skp += 1;  // ok
}
