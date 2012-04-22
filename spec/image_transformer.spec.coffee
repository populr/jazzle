Transformer = require('./lib/image_transformer').ImageTransformer
transformer = new Transformer()

describe "Transformer#_calcSize", ->
	describe "when width is 0, and height is 0", ->
		it "should have action set to none", ->
			result = transformer._calcSize "test.jpg", "/0/0/http://s3.amazon.com/dimages.populr.me/test/3_8.jpg"
			expect(result.action).toEqual "none"
	describe "when width is positive, and height is 0", ->
		it "should have action set to resize", ->
			result = transformer._calcSize "test.jpg", "/200/0/http://s3.amazon.com/dimages.populr.me/test/3_8.jpg"
			expect(result.action).toEqual "resize"
	describe "when width is 0, and height is positive", () ->
	describe "when width is positive, and height is positive", () ->
	describe "when focus point is present", () ->
		it "should ", () ->
		describe "when focus point is too far right to make it the center", () ->
		describe "when focus point is too far left to make it the center", () ->
		describe "when focus point is too high to make it the center", () ->
		describe "when focus point is too low to make it the center", () ->
	describe "when crop rectangle is defined", () ->

#/w/h/x-y/x-y