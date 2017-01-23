--Spiritual Fusion
--Scripted by Edo9300
function c511004008.initial_effect(c)
	local fsel=Duel.SelectFusionMaterial
	Duel.SelectFusionMaterial=function(tp,c,g,gc,chkf)
		if c:IsCode(511000990) then
			if g:IsExists(c511000990.sameplayerchk,1,nil,tp) then
				local mg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_SZONE,0,nil)
				g:Merge(mg1)
			end
			if g:IsExists(c511000990.sameplayerchk,1,nil,1-tp) then
				local mg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_SZONE,0,nil)
				local mg2=Duel.GetMatchingGroup(c511000990.mat2,tp,0,LOCATION_SZONE,nil)
				g:Merge(mg1)
				g:Merge(mg2)
			end
		end
		if Duel.IsPlayerAffectedByEffect(1-tp,5000) and Duel.SelectYesNo(1-tp,aux.Stringid(4002,8)) then  
 			Duel.ConfirmCards(1-tp,g)
 			local label=0
 			if g:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) or (gc and gc:IsLocation(LOCATION_HAND)) then label=label+1 end
 			if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) or (gc and gc:IsLocation(LOCATION_DECK)) then label=label+2 end
 			Duel.RegisterFlagEffect(1-tp,511004008+label,0,0,1)
 			return fsel(1-tp,c,g,gc,chkf)
 		end
		return fsel(tp,c,g,gc,chkf)
	end
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511004008.activate)
	c:RegisterEffect(e1)
end
function c511004008.op(e)
	local tp=e:GetLabel()
	if Duel.GetFlagEffect(tp,511004009)>0 or Duel.GetFlagEffect(tp,511004011)>0 then
		Duel.ShuffleHand(1-tp) end
	if Duel.GetFlagEffect(tp,511004010)>0 or Duel.GetFlagEffect(tp,511004011)>0 then
		Duel.ShuffleDeck(1-tp) end
	Duel.ResetFlagEffect(tp,511004008)
	Duel.ResetFlagEffect(tp,511004009)
	Duel.ResetFlagEffect(tp,511004010)
	Duel.ResetFlagEffect(tp,511004011)
end
function c511004008.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(5000)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END,1)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,e:GetHandlerPlayer())
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetLabel(tp)
	e2:SetOperation(c511004008.op)
	e2:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(e2,e:GetHandlerPlayer())
end
