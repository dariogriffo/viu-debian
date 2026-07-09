VIU_VERSION=$1
BUILD_VERSION=$2
ARCH=${3:-amd64}  # Default to amd64 if no architecture specified

if [ -z "$VIU_VERSION" ] || [ -z "$BUILD_VERSION" ]; then
    echo "Usage: $0 <viu_version> <build_version> [architecture]"
    echo "Example: $0 1.6.1 1 arm64"
    echo "Example: $0 1.6.1 1 all    # Build for all architectures"
    echo "Supported architectures: amd64, arm64, all"
    exit 1
fi

# Function to map Debian architecture to viu release name
get_viu_release() {
    local arch=$1
    case "$arch" in
        "amd64")
            echo "x86_64"
            ;;
        "arm64")
            echo "aarch64"
            ;;
        *)
            echo ""
            ;;
    esac
}

# Function to build for a specific architecture
build_architecture() {
    local build_arch=$1
    local viu_release

    viu_release=$(get_viu_release "$build_arch")
    if [ -z "$viu_release" ]; then
        echo "❌ Unsupported architecture: $build_arch"
        echo "Supported architectures: amd64, arm64"
        return 1
    fi

    echo "Building for architecture: $build_arch using $viu_release"

    mkdir -p "$viu_release"

    # Download viu binary for this architecture
    if ! wget "https://github.com/atanunq/viu/releases/download/v${VIU_VERSION}/viu-${viu_release}-unknown-linux-musl" -O "${viu_release}/viu"; then
        echo "❌ Failed to download viu binary for $build_arch"
        return 1
    fi
    chmod +x "${viu_release}/viu"

    # Build packages for all Debian distributions
    declare -a arr=("bookworm" "trixie" "forky" "sid")

    for dist in "${arr[@]}"; do
        FULL_VERSION="$VIU_VERSION-${BUILD_VERSION}~${dist}_${build_arch}"
        echo "  Building $FULL_VERSION"

        if ! docker build . -t "viu-$dist-$build_arch" \
            --build-arg DEBIAN_DIST="$dist" \
            --build-arg VIU_VERSION="$VIU_VERSION" \
            --build-arg BUILD_VERSION="$BUILD_VERSION" \
            --build-arg FULL_VERSION="$FULL_VERSION" \
            --build-arg ARCH="$build_arch" \
            --build-arg VIU_RELEASE="$viu_release"; then
            echo "❌ Failed to build Docker image for $dist on $build_arch"
            return 1
        fi

        id="$(docker create "viu-$dist-$build_arch")"
        if ! docker cp "$id:/viu_$FULL_VERSION.deb" - > "./viu_$FULL_VERSION.deb"; then
            echo "❌ Failed to extract .deb package for $dist on $build_arch"
            return 1
        fi

        if ! tar -xf "./viu_$FULL_VERSION.deb"; then
            echo "❌ Failed to extract .deb contents for $dist on $build_arch"
            return 1
        fi
    done

    echo "✅ Successfully built for $build_arch"
    return 0
}

# Main build logic
if [ "$ARCH" = "all" ]; then
    echo "🚀 Building viu $VIU_VERSION-$BUILD_VERSION for all supported architectures..."
    echo ""

    # All supported architectures
    ARCHITECTURES=("amd64" "arm64")

    for build_arch in "${ARCHITECTURES[@]}"; do
        echo "==========================================="
        echo "Building for architecture: $build_arch"
        echo "==========================================="

        if ! build_architecture "$build_arch"; then
            echo "❌ Failed to build for $build_arch"
            exit 1
        fi

        echo ""
    done

    echo "🎉 All architectures built successfully!"
    echo "Generated packages:"
    ls -la viu_*.deb
else
    # Build for single architecture
    if ! build_architecture "$ARCH"; then
        exit 1
    fi
fi
