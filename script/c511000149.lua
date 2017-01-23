--Kuribandit
function c511000149.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511000149.splimit)
	c:RegisterEffect(e1)
	--effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000149,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_STANDBY_PHASE+0x1c0)	
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511000149.drcost)
	e2:SetTarget(c511000149.drtg)
	e2:SetOperation(c511000149.drop)
	c:RegisterEffect(e2)
end
function c511000149.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(511000152)
end
function c511000149.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511000149.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,5) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(5)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,5)
end
function c511000149.drop(e,tp,eg,ep,ev,re,r,rp,chk)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetDecktopGroup(p,d)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.ConfirmCards(1-p,g)
	g=g:Filter(Card.IsType,nil,TYPE_MONSTER)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
