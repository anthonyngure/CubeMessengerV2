@component('mail::message')
####{{Carbon\Carbon::now()->toDayDateTimeString()}}
#### Dear {{$supplier->name}},

Below is a list of items you have confirmed to deliver
@component('mail::table')
    |Item| Quantity   |Price|Total
    |:-------|:----------:|----------:|----------:|
    @foreach($items as $item)
        |{{$item->orderItem->product->name}}|{{$item->orderItem->quantity}}|{{\App\Utils::toCurrencyText($item->orderItem->price_at_purchase)}}|{{\App\Utils::toCurrencyText($item->orderItem->quantity * $item->orderItem->price_at_purchase)}}|
    @endforeach
    |*********|*********|*********|{{\App\Utils::toCurrencyText($total)}}|
@endcomponent
Thanks,<br>
{{ config('app.name') }}
@endcomponent
