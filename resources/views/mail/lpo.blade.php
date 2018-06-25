@component('mail::message')
####{{Carbon\Carbon::now()->toDayDateTimeString()}}
#### Dear {{$supplier->name}},

Below is a list of items you have confirmed to deliver
@component('mail::table')
    |Item| Quantity   |
    |:-------|:----------:|
    @foreach($items as $item)
        |{{$item->orderItem->product->name}}|{{$item->orderItem->quantity}}|
    @endforeach
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent
