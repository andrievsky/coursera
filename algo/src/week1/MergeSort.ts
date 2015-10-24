/**
 * Created by nick on 10/21/15.
 */
class MergeSort {

    private numbers:number[];
    private helper:number[];

    private length:number;

    public sort(values:number[]) {
        this.numbers = values;
        this.length = values.length;
        this.helper = [];
        this.mergesort(0, this.length - 1);
    }

    private mergesort(low:number, high:number) {
        // check if low is smaller then high, if not then the array is sorted
        if (low < high) {
            // Get the index of the element which is in the middle
            var middle:number = Math.floor(low + (high - low) / 2);
            // Sort the left side of the array
            this.mergesort(low, middle);
            // Sort the right side of the array
            this.mergesort(middle + 1, high);
            // Combine them both
            this.merge(low, middle, high);
        }
    }

    private merge(low:number, middle:number, high:number) {

        // Copy both parts into the helper array
        for (var i:number = low; i <= high; i++) {
            this.helper[i] = this.numbers[i];
        }

        var i:number = low;
        var j:number = middle + 1;
        var k:number = low;
        // Copy the smallest values from either the left or the right side back
        // to the original array
        while (i <= middle && j <= high) {
            if (this.helper[i] <= this.helper[j]) {
                this.numbers[k] = this.helper[i];
                i++;
            } else {
                this.numbers[k] = this.helper[j];
                j++;
            }
            k++;
        }
        // Copy the rest of the left side of the array into the target array
        while (i <= middle) {
            this.numbers[k] = this.helper[i];
            k++;
            i++;
        }

    }
}