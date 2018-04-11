# used to have one source for directory structure,
# array elements can be renamed,
# changing position in array breaks relations,
# for reverse searches dirlevels are written in hierarchical order

module A241DIR
  @tempdirs = ["pages","pages/a241","pages/a241/images","pages/txt","pages/tmp"]
  @statdirs = ["data","data/csv"]
    def self.tempdirs
      @tempdirs
    end
    def self.statdirs
      @statdirs
    end
end
