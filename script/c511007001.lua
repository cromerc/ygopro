--coded by Lyris
--Absolute Buster
function c511007001.initial_effect(c)
	--This turn, negate all Spell/Trap Card effects that would negate an attack and/or prevent a card(s) from being destroyed. [Trap Stun & Necrovalley]
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511007001.activate)
	c:RegisterEffect(e1)
end
function c511007001.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c511007001.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetOperation(c511007001.disoperation)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	--disable trap monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c511007001.distarget)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c511007001.distarget(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_SPELL+TYPE_TRAP) and
		--prevents destruction
		(c:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) or c:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT) or c:IsHasEffect(EFFECT_INDESTRUCTABLE_COUNT) or c:IsHasEffect(EFFECT_DESTROY_REPLACE))
end
function c511007001.disoperation(e,tp,eg,ep,ev,re,r,rp)
	local ec=Duel.GetAttacker()
	local rc=re:GetHandler()
	local targets=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local res=true
	--Checks if the effect to be negated makes the attacking monster leave the field; most cards don't do that if they negate attacks
	local category={CATEGORY_DESTROY,CATEGORY_RELEASE,CATEGORY_REMOVE,CATEGORY_TODECK,CATEGORY_TOGRAVE,CATEGORY_TOHAND}
	for i=0,5 do
		local ex,tg,ct,p,v=Duel.GetOperationInfo(ev,category[i])
		if ex then
			if tg and tg:GetCount()>0 then
				if tg:IsContains(ec) then res=false end
			end
		end
	end
	--Note: This cannot negate non-Targeting attack negation.
	if re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and (res or (rc:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) or rc:IsHasEffect(EFFECT_INDESTRUCTABLE_EFFECT) or rc:IsHasEffect(EFFECT_INDESTRUCTABLE_COUNT))) then
		Duel.NegateEffect(ev)
	end
end
