package PublishEmptyArchive::Patch;
use strict;

sub init { 1; }

require MT::ArchiveType::Category;
*MT::ArchiveType::Category::does_publish_file = sub {
    my $obj    = shift;
    my %params = %{ shift() };
    if ( !$params{Category} && $params{Entry} ) {
        $params{Category} = $params{Entry}->category;
    }
    return 0 unless $params{Category};

    # PATCH
    return 1 if $params{Blog}->publish_empty_archive;
    # /PATCH

    MT::ArchiveType::archive_entries_count( $obj, \%params );
};

1;
