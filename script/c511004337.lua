--Dark Auction
--Scripted by andré
function c511004337.initial_effect(c)
   --return to hand
   local e1=Effect.CreateEffect(c)
   e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DAMAGE)
   e1:SetType(EFFECT_TYPE_ACTIVATE)
   e1:SetCode(EVENT_FREE_CHAIN)
   e1:SetTarget(c511004337.tg)
   e1:SetOperation(c511004337.op)
   c:RegisterEffect(e1)
end
function c511004337.tfilter(c)
   return c:GetCounter(0x1107)~=0
end
function c511004337.tg(e,tp,eg,ep,ev,re,r,rp,chk)
   if chk==0 then return Duel.IsExistingMatchingCard(c511004337.tfilter,tp,LOCATION_ONFIELD,0,1,nil) end
   local g=Duel.GetMatchingGroup(c511004337.tfilter,tp,LOCATION_ONFIELD,0,nil)
   Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511004337.op(e,tp,eg,ep,ev,re,r,rp)
   local g=Duel.GetMatchingGroup(c511004337.tfilter,tp,LOCATION_ONFIELD,0,nil)
   local g=Duel.SelectMatchingCard(tp,c511004337.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
   local tc=g:GetFirst()
   local dam=tc:GetAttack()
   if tc then
	   Duel.SendtoHand(g,nil,REASON_EFFECT)
	   Duel.Damage(1-tp,dam,REASON_EFECT)
   end
end