local path = require('path')

describe("path module", function()
    describe("is_absolute", function ()
        it("should return true for absolute paths", function ()
            assert.is_true(path.is_absolute("c:/foo.bar"))
            assert.is_true(path.is_absolute("c:/foo.bar/baz"))
            assert.is_true(path.is_absolute("c:\\foo.bar"))
            assert.is_true(path.is_absolute("c:\\foo.bar\\baz"))
            assert.is_true(path.is_absolute("z:/baz\\foo.bar"))
            assert.is_true(path.is_absolute("z:\\baz/foo.bar"))
            assert.is_true(path.is_absolute("c:/quux/..\\baz/foo.bar"))
        end)

        it("should return false for relative paths", function ()
            assert.is_false(path.is_absolute("./foo.bar"))
            assert.is_false(path.is_absolute(".\\baz"))
            assert.is_false(path.is_absolute("foo.bar"))
            assert.is_false(path.is_absolute(".\\foo.bar\\baz"))
            assert.is_false(path.is_absolute("./baz\\foo.bar"))
            assert.is_false(path.is_absolute("..\\baz/foo.bar"))
        end)
    end)
end)
